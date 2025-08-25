function heredoc
    set filename $argv[1]
    set content $argv[2..-1]

    echo $content | bash -c "cat > $filename"
end
