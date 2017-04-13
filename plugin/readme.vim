" Must pass the repo as a string, i.e. 'anhari/vim-readme'
function! FetchStars(username)
  execute 'silent !ruby ~/.vim/bundle/vim-readme/lib/fetch_star_list.rb ' . a:username
  echo 'Fetching of your starred repositores is complete!'
endfunction

function! OpenREADME(user_and_repo)
  execute 'silent !open https:\/\/github.com\/' . a:user_and_repo . '\#readme'
endfunction

function! OpenStarredReadme(readme)
  execute 'silent !open https:\/\/github.com\/' . a:readme . '\#readme'
endfunction

function! FindREADME()
  if filereadable("starred_repositories.txt")
    call fzf#run({
        \ 'source': 'grep --line-buffered --color=never -hrsi --include=starred_repositories.txt "" * ',
        \ 'down':   '40%',
        \ 'sink':   function('OpenStarredReadme')})
  else
    echo "Run the FetchStars <github_username> command to populate your stars!"
  endif

endfunction

command! -nargs=1 OpenREADME call OpenREADME(<f-args>)
command! -nargs=1 FetchStars call FetchStars(<f-args>)
command! -nargs=0 FindREADME call FindREADME(<f-args>)
