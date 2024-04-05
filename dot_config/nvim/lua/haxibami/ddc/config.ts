import { BaseConfig, ConfigArguments, fn } from "./deps.ts";

export class Config extends BaseConfig {
  override async config(args: ConfigArguments): Promise<void> {
    args.contextBuilder.patchGlobal({
      ui: "pum",
      sources: ["lsp", "around", "file"],
      autoCompleteEvents: [
        "InsertEnter",
        "TextChangedI",
        "TextChangedP",
        "CmdlineEnter",
        "CmdlineChanged",
        "TextChangedT",
      ],
      cmdlineSources: {
        ":": ["cmdline", "cmdline-history", "around", "file"],
        "@": ["around"],
        ">": ["around"],
        "/": ["around"],
        "?": ["around"],
        "-": ["around"],
        "=": ["around"],
        //         "@": ["input", "cmdline-history", "file", "around"],
        //         ">": ["input", "cmdline-history", "file", "around"],
        //         "/": ["around", "line"],
        //         "?": ["around", "line"],
        //         "-": ["around", "line"],
        //         "=": ["input"],
      },
      sourceOptions: {
        _: {
          ignoreCase: true,
          matchers: ["matcher_fuzzy"],
          sorters: ["sorter_fuzzy"],
          converters: ["converter_fuzzy"],
          timeout: 1000,
        },
        lsp: {
          mark: "",
          forceCompletionPattern: "\\.|:\\s*|->\\s*",
          dup: "force",
        },
        around: {
          mark: "",
        },
        //         necovim: {
        //           mark: "vim",
        //         },
        //         "nvim-lua": {
        //           mark: "lua",
        //           forceCompletionPattern: "\\.\\w*",
        //         },
        file: {
          mark: "",
          isVolatile: true,
          minAutoCompleteLength: 1000,
          forceCompletionPattern: "\\S/\\S*",
        },
        cmdline: {
          mark: "",
          forceCompletionPattern: "\\S/\\S*|\\.\\w*",
          // forceCompletionPattern: "[\\w@:~._-]/[\\w@:~._-]*",
        },
        "cmdline-history": {
          mark: "",
          // sorters: [],
        },
        //         buffer: {
        //           mark: "B",
        //         },
        //         copilot: {
        //           mark: "cop",
        //           matchers: [],
        //           minAutoCompleteLength: 0,
        //           isVolatile: false,
        //         },
        //         codeium: {
        //           mark: "cod",
        //           matchers: ["matcher_length"],
        //           minAutoCompleteLength: 0,
        //           isVolatile: true,
        //         },
        //         input: {
        //           mark: "input",
        //           forceCompletionPattern: "\\S/\\S*",
        //           isVolatile: true,
        //         },
        //         line: {
        //           mark: "line",
        //           matchers: ["matcher_vimregexp"],
        //        },
        //         mocword: {
        //           mark: "mocword",
        //           minAutoCompleteLength: 4,
        //           isVolatile: true,
        //         },
        //         rtags: {
        //           mark: "R",
        //           forceCompletionPattern: "\\.\\w*|::\\w*|->\\w*",
        //         },
        //         "shell-history": {
        //           mark: "history",
        //         },
        //         shell: {
        //           mark: "shell",
        //           isVolatile: true,
        //           forceCompletionPattern: "\\S/\\S*",
        //         },
        //         zsh: {
        //           mark: "zsh",
        //           isVolatile: true,
        //           forceCompletionPattern: "\\S/\\S*",
        //         },
        //         rg: {
        //           mark: "rg",
        //           minAutoCompleteLength: 5,
        //           enabledIf: "finddir('.git', ';') != ''",
        //         },
        //         skkeleton: {
        //           mark: "skk",
        //           matchers: ["skkeleton"],
        //           sorters: [],
        //           minAutoCompleteLength: 2,
        //           isVolatile: true,
        //         },
      },
      sourceParams: {
        lsp: {
          enableResolveItem: true,
          enableAdditionalTextEdit: true,
          kindLabels: { Class: "c" },
        },
        file: {
          filenameChars: "[:keyword:].",
        },
      },
      filterParams: {
        matcher_fuzzy: {
          splitMode: "word",
        },
      },
    });

    //     for (const filetype of [
    //       "help",
    //       "vimdoc",
    //       "markdown",
    //       "gitcommit",
    //       "comment",
    //     ]) {
    //       args.contextBuilder.patchFiletype(filetype, {
    //         sources: ["around", "codeium", "mocword"],
    //       });
    //     }
    //
    //     for (const filetype of ["html", "css"]) {
    //       args.contextBuilder.patchFiletype(filetype, {
    //         keywordPattern: "[0-9a-zA-Z_:#-]*",
    //       });
    //     }
    //
    //     const hasWindows = await fn.has(args.denops, "win32");
    //     for (const filetype of ["zsh", "sh", "bash"]) {
    //       args.contextBuilder.patchFiletype(filetype, {
    //         keywordPattern: "[0-9a-zA-Z_./#:-]*",
    //         sources: [hasWindows ? "shell" : "zsh", "around"],
    //       });
    //     }
    //     args.contextBuilder.patchFiletype("deol", {
    //       specialBufferCompletion: true,
    //       keywordPattern: "[0-9a-zA-Z_./#:-]*",
    //       sources: [hasWindows ? "shell" : "zsh", "shell-history", "around"],
    //     });
    //
    //     args.contextBuilder.patchFiletype("ddu-ff-filter", {
    //       keywordPattern: "[0-9a-zA-Z_:#-]*",
    //       sources: ["line", "buffer"],
    //       specialBufferCompletion: true,
    //     });
    //
    //     const hasNvim = await fn.has(args.denops, "nvim");
    //     if (hasNvim) {
    //       for (const filetype of [
    //         "css",
    //         "go",
    //         "html",
    //         "python",
    //         "ruby",
    //         "typescript",
    //         "typescriptreact",
    //       ]) {
    //         args.contextBuilder.patchFiletype(filetype, {
    //           sources: ["codeium", "lsp", "around"],
    //         });
    //       }
    //
    //       args.contextBuilder.patchFiletype("lua", {
    //         sources: ["codeium", "lsp", "nvim-lua", "around"],
    //       });
    //     }
  }
}
