From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 17:35:53 +0200
Subject: [LTP] RFC remove README.kernel_config
Message-ID: <YJv12RslhxorXEf2@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

does anybody use README.kernel_config? Is it useful for anybody?
There is a patch [1] which enhances it, but I'd prefer to delete it and replaces
the content with .needs_kconfigs setup [2].

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210302073248.10204-1-pankaj.joshi347@gmail.com/
[2] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2228-parsing-kernel-config
