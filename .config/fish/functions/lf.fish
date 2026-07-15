function lf
    set -l tmpfile (mktemp)

    command ranger --choosedir=$tmpfile $argv

    if test -s $tmpfile
        cd (cat $tmpfile)
    end

    rm -f $tmpfile
end
