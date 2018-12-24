backup '/Users/xiao.wang/Documents'

backup '/Users/xiao.wang/Downloads', name('*.pdf') | name('*.doc*')

backup '/User/xiao.wang/Pictures', except(file_name('*.tmp'))

to '/external_drive/backups'

interval 1
