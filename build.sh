
# package发布脚本，默认版本号读取Assets/Package/package.json文件中的version字段，分支名称为package
# 传参需要传递两个参数 $1：版本号  $2：分支名称

# 处理版本号
if [ -z $1 ]
then
    VER=$(cat Assets/Package/package.json)
    result1=${VER#*\"version\"\: \"}
    result2=${result1%%\",*}
    echo "$result2"
    version=$result2
else
    version=$1
fi
# 处理分支名称
if [ -z $2 ]
then
    branch="package"
else
    branch=$2
fi

echo "---- 构建参数 ----"
echo "版本号：$version"
echo "分支名称: $branch"
echo "------------------"

# 构建分组并发布
# 将Assets/Package分离拆成单独分支
git subtree split --prefix=Assets/Package --branch $branch
# 打对应版本号tag分支
git tag $version $branch
# 推送到远端
git push origin $branch --tags

echo "版本发布完成！"