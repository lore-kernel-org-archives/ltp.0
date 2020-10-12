From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 12 Oct 2020 10:53:26 +0200
Subject: [LTP] [PATCH 00/11] Test metadata extraction
In-Reply-To: <20201005133054.23587-1-chrubis@suse.cz>
References: <20201005133054.23587-1-chrubis@suse.cz>
Message-ID: <20201012085326.GA29137@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> This patchset adds a test metadata extraction into LTP and also
> documentation generator that produces browseable HTML documentation from
> the exported metadata. For detailed description of the idea and
> implementation see the patch that adds README.md.

> While the idea is quite new the code is mature enough to be included in
> the upstream repository and I'm also worried that we will not get any
> feedback or users of the metadata unless it's included in the upstream
> git.

Example of the output:
(generally I prefer asciidoctor, but PDF support is not always available)
HTML could have custom javascript (probably jquery) based search/filtering.

= asciidoctor
* PDF
https://pevik.github.io/asciidoctor/metadata.pdf
There is missing TOC (as :toc: does not work and adding '-a toc' to generate as:
asciidoctor -d book metadata.txt -b pdf -r asciidoctor-pdf -a toc

puts TOC at the top.

* HTML single page
https://pevik.github.io/asciidoctor/metadata.html

= asciidoc
* PDF
https://pevik.github.io/asciidoc/metadata.pdf
There is ugly revision history at the top.

* HTML single page
https://pevik.github.io/asciidoc/metadata.html

* HTML chunked
https://pevik.github.io/asciidoc/metadata.chunked/index.html
https://pevik.github.io/asciidoc/metadata.chunked/ch01.html
https://pevik.github.io/asciidoc/metadata.chunked/ch02.html
https://pevik.github.io/asciidoc/metadata.chunked/ch03.html

> The next step is to use the extracted metadata in runltp-ng in the proof
> of concept parallel executor that has been written by Ritchie and posted
> to this mailing list as well.

Kind regards,
Petr
