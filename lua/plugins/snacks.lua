return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
 ██████╗██████╗  █████╗ ██╗   ██╗ ██████╗ ███╗   ██╗███████╗ ██████╗ ██████╗ ██╗███╗   ███╗
██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝██╔═══██╗████╗  ██║╚══███╔╝██╔════╝ ██╔══██╗██║████╗ ████║
██║     ██████╔╝███████║ ╚████╔╝ ██║   ██║██╔██╗ ██║  ███╔╝ ██║  ███╗██████╔╝██║██╔████╔██║
██║     ██╔══██╗██╔══██║  ╚██╔╝  ██║   ██║██║╚██╗██║ ███╔╝  ██║   ██║██╔══██╗██║██║╚██╔╝██║
╚██████╗██║  ██║██║  ██║   ██║   ╚██████╔╝██║ ╚████║███████╗╚██████╔╝██║  ██║██║██║ ╚═╝ ██║
 ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝
   ]],
      },
    },
    picker = {
      win = {
        input = {
          keys = {
            -- Alt+C로 작업 디렉토리 토글 (프로젝트 루트 ↔ 현재 디렉토리)
            ["<a-c>"] = {
              "toggle_cwd",
              mode = { "n", "i" },
            },
          },
        },
      },
      actions = {
        ---@param p snacks.Picker
        -- 작업 디렉토리를 프로젝트 루트와 현재 디렉토리 사이에서 토글
        toggle_cwd = function(p)
          local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
          local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
          local current = p:cwd()
          p:set_cwd(current == root and cwd or root)
          p:find()
        end,
      },
    },
  },
  keys = {
    -- ========== 기본 단축키 ==========
    {
      "<leader>ss",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>,",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers", -- 열린 버퍼 목록 표시
    },
    { "<leader>/", LazyVim.pick("grep"), desc = "Grep (Root Dir)" }, -- 프로젝트 루트에서 텍스트 검색
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History", -- 명령어 히스토리 검색
    },
    -- { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    {
      "<leader>n",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History", -- 알림 히스토리 표시
    },
    {
      "<c-/>",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal", -- 터미널 토글
    },

    -- ========== 파일 찾기 (find) ==========
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers", -- 열린 버퍼 목록
    },
    {
      "<leader>fB",
      function()
        Snacks.picker.buffers({ hidden = true, nofile = true })
      end,
      desc = "Buffers (all)", -- 숨김 버퍼 포함 전체 버퍼 목록
    },
    { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" }, -- 설정 파일 찾기
    { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" }, -- 프로젝트 루트에서 파일 찾기
    { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" }, -- 현재 디렉토리에서 파일 찾기
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find Files (git-files)", -- Git 추적 파일만 찾기
    },
    { "<leader>fR", LazyVim.pick("oldfiles"), desc = "Recent" }, -- 최근 열었던 파일 목록 (전체)
    {
      "<leader>fr",
      function()
        Snacks.picker.recent({ filter = { cwd = true } })
      end,
      desc = "Recent (cwd)", -- 최근 열었던 파일 목록 (현재 디렉토리만)
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects", -- 프로젝트 목록
    },

    -- ========== Git 관련 ==========
    {
      "<leader>gd",
      function()
        Snacks.picker.git_diff()
      end,
      desc = "Git Diff (hunks)", -- Git 변경사항(hunk) 목록
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status", -- Git 상태 표시
    },
    {
      "<leader>gS",
      function()
        Snacks.picker.git_stash()
      end,
      desc = "Git Stash", -- Git stash 목록
    },
    -- lazygit
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit log (cwd)", -- Lazygit 로그 뷰어 열기
    },

    -- ========== 검색 (Grep) ==========
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines", -- 현재 버퍼 내 라인 검색
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers", -- 열린 버퍼들에서 텍스트 검색
    },
    { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" }, -- 프로젝트 루트에서 실시간 검색
    { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" }, -- 현재 디렉토리에서 실시간 검색
    {
      "<leader>sp",
      function()
        Snacks.picker.lazy()
      end,
      desc = "Search for Plugin Spec", -- 플러그인 설정 파일 검색
    },
    { "<leader>sw", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } }, -- 커서 아래 단어 또는 선택 영역 검색
    {
      "<leader>sW",
      LazyVim.pick("grep_word", { root = false }),
      desc = "Visual selection or word (cwd)",
      mode = { "n", "x" },
    },

    -- ========== 검색 (search) - Vim 내부 기능 ==========
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers", -- 레지스터 목록 (복사/붙여넣기 히스토리)
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Search History", -- 검색 히스토리 (/ 검색)
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds", -- 자동 명령 목록
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History", -- 명령어 히스토리 (: 명령)
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands", -- 사용 가능한 명령어 목록
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics", -- 전체 진단 메시지 (에러/경고)
    },
    {
      "<leader>sD",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics", -- 현재 버퍼의 진단 메시지
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages", -- 도움말 페이지 검색
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights", -- 하이라이트 그룹 목록
    },
    {
      "<leader>si",
      function()
        Snacks.picker.icons()
      end,
      desc = "Icons", -- 아이콘 검색 및 복사
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Jumps", -- 점프 목록 (이전에 이동했던 위치들)
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps", -- 키맵 목록 검색
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Location List", -- 위치 목록
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "Man Pages", -- 매뉴얼 페이지 검색
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks", -- 마크 목록 (m + 문자로 설정한 위치)
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume", -- 마지막 picker 다시 열기
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Quickfix List", -- Quickfix 목록
    },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undotree", -- 실행 취소 트리 (변경 히스토리)
    },

    -- ========== UI 관련 ==========
    {
      "<leader>uC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Colorschemes", -- 컬러스킴 미리보기 및 변경
    },
  },
}
