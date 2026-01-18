function shredd
    find $argv -type f -exec shred -uvz --iterations=5 {} +
    
    find $argv -type l -exec rm -v {} +
    
    find $argv -depth -type d | while read -l dir
        set randname "/tmp/shredded_tmp_"(random)
        mv "$dir" "$randname"
        rmdir "$randname"
    end
end
