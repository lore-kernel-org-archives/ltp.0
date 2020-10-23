From: Li Wang <liwang@redhat.com>
Date: Fri, 23 Oct 2020 14:18:42 +0800
Subject: [LTP] [PATCH 11/11] docparse: Generate html and pdf using
 asciidoc{, tor}
In-Reply-To: <20201005133054.23587-12-chrubis@suse.cz>
References: <20201005133054.23587-1-chrubis@suse.cz>
 <20201005133054.23587-12-chrubis@suse.cz>
Message-ID: <CAEemH2cE64fq2Qn1AEuLQN5aBWv7MRykEpc5Bw=_4H5N1ZJYkw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:

> --- a/docparse/Makefile
> +++ b/docparse/Makefile
> @@ -1,19 +1,77 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
>
>  top_srcdir             ?= ..
>
>  include $(top_srcdir)/include/mk/env_pre.mk
>  include $(top_srcdir)/include/mk/functions.mk
>
> +ifeq ($(METADATA_GENERATOR),asciidoctor)
> +METADATA_GENERATOR_CMD := asciidoctor
> +METADATA_GENERATOR_PARAMS := -d book metadata.txt
> +METADATA_GENERATOR_PARAMS_HTML := -b xhtml
> +METADATA_GENERATOR_PARAMS_PDF := -b pdf -r asciidoctor-pdf
> +else ifeq ($(METADATA_GENERATOR),asciidoc)
> +METADATA_GENERATOR_CMD := a2x
> +METADATA_GENERATOR_PARAMS := --xsltproc-opts "--stringparam toc.section.depth 1" -d book -L  --resource="$(PWD)" metadata.txt
> +METADATA_GENERATOR_PARAMS_HTML := -f xhtml
> +METADATA_GENERATOR_PARAMS_PDF := -f pdf
> +METADATA_GENERATOR_PARAMS_HTML_CHUNKED := -f chunked
> +else ifeq ($(METADATA_GENERATOR),)
> +$(error 'METADATA_GENERATOR' not not configured, run ./configure in the root directory)
> +else
> +$(error '$(METADATA_GENERATOR)' not supported, only asciidoctor and asciidoc are supported)
> +endif
> +
> +ifdef VERBOSE
> +METADATA_GENERATOR_PARAMS += -v
> +endif
> +
> +CLEAN_TARGETS          := *.txt

I guess the generated  *.css *.js files should be deleted as well.

--
Regards,
Li Wang

