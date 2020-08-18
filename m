From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Tue, 18 Aug 2020 17:37:07 +0800
Subject: [LTP] [PATCH 1/2] lib/tst_kvercmp: Add support to get distname
 for Ubuntu in tst_kvcmp_distname
In-Reply-To: <20200817124504.GC8445@yuki.lan>
References: <20200817120644.9401-1-po-hsu.lin@canonical.com>
 <20200817120644.9401-2-po-hsu.lin@canonical.com>
 <20200817123403.GA8445@yuki.lan> <20200817124504.GC8445@yuki.lan>
Message-ID: <CAMy_GT8YkSR_xM9iwSGEG55XewODiVAbDnhrkp5S-_M0R3xb4g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 17, 2020 at 8:44 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > It should be as easy as one SAFE_FILE_SCANF() in the case that the file
> > exists.
>
> It's SAFE_FILE_LINES_SCANF()

Hello Cyril,
thanks for your suggestion, I will submit V2 for this.

>
> --
> Cyril Hrubis
> chrubis@suse.cz
