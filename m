From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Apr 2021 19:03:02 +0800
Subject: [LTP] runltp-ng and possible ltp-pan deprecation
In-Reply-To: <YH7Z8nOX90qjsMpa@yuki>
References: <YH7Z8nOX90qjsMpa@yuki>
Message-ID: <CAEemH2cWeKBGcntjHQco39sZd0qXNxmgheunj__Y1kqxhfmyNA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Cyril Hrubis <chrubis@suse.cz> wrote:

>
> Hi!
> As you may have know some time ago I have started to work on runltp-ng a
> script to replace runltp and ltp-pan.
>
> The new executor is different in several key aspects, for example:
>
> - it can and is supposed to run on a different machine from the system
>   under test (although it still supports running on the same machine)
>
> - there are different backends, it can run tests locally, over ssh, or
>   start a VM with qemu
>
> - produces different output formats currently html or json
>

Very nice features. Thanks!

>
> Also there are two different options how to do that. Either we put it
> into runltp-ng directory to the LTP git root or we may as well create a
> separate repository under the linux-test-project and make it a ltp git
> submodule. Any preferencies to that?
>

I prefer the LTP git root as well.

Btw, I opened a PR for some tiny issues fixing, plz help review.
https://github.com/metan-ucw/runltp-ng/pull/28

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210426/57080db9/attachment.htm>
