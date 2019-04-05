From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 5 Apr 2019 08:56:09 +0200
Subject: [LTP] [PATCH 1/1] Remove break after return
In-Reply-To: <5CA6C9F7.1060907@cn.fujitsu.com>
References: <20190328105006.17337-1-pvorel@suse.cz>
 <5CA6C9F7.1060907@cn.fujitsu.com>
Message-ID: <20190405065609.GA26076@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> I have added libc sigpending() detection by the following patch:
> http://lists.linux.it/pipermail/ltp/2019-April/011590.html

> Perhaps, we should avoid potential compiler warnings by keeping the
> break here.
Oh yes, adding break after tst_brk in [1] (in case of #ifndef HAVE_STIME) is correct.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1077969/
