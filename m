From: Li Wang <liwang@redhat.com>
Date: Wed, 19 May 2021 18:29:12 +0800
Subject: [LTP] [PATCH 1/2] shell: Fix timeout process termination for zsh
In-Reply-To: <8555aa72-3288-c1a9-d6f1-3998c15d630e@jv-coder.de>
References: <20210519063109.224352-1-lkml@jv-coder.de>
 <CAEemH2fcuMtZgthknbsLKHdhqq7NrtB=nm6Oi9pvxG6MH0_jsQ@mail.gmail.com>
 <8555aa72-3288-c1a9-d6f1-3998c15d630e@jv-coder.de>
Message-ID: <CAEemH2e5cdb4G=cpV3amf=-JaeVGBDpC7WX4YTubF7wzr3FNDg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> I may have something to do with subshells again...
> I just tweaked your reproducer, to be a bit more like our "real
> scenario" and can reproduce it:

Yes, I can reproduce it now.

>
> timeout()
> {
>      sleep 100 &
>      sleep_pid=$!
>      trap "echo Received TERM; kill $sleep_pid; exit;" TERM
>      wait $sleep_pid
>      [ $? -eq 143 ] && echo "FAIL"
> }
>
> timeout &
> pid=$!
> sleep 1
> kill $pid
>
>
> $ bash test.sh
> Received TERM
>
> $ zsh test.sh
> Received TERM
> FAIL
>
> J?rg
>
>


-- 
Regards,
Li Wang

