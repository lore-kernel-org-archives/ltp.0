From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 19 May 2021 12:26:46 +0200
Subject: [LTP] [PATCH 1/2] shell: Fix timeout process termination for zsh
In-Reply-To: <CAEemH2fcuMtZgthknbsLKHdhqq7NrtB=nm6Oi9pvxG6MH0_jsQ@mail.gmail.com>
References: <20210519063109.224352-1-lkml@jv-coder.de>
 <CAEemH2fcuMtZgthknbsLKHdhqq7NrtB=nm6Oi9pvxG6MH0_jsQ@mail.gmail.com>
Message-ID: <8555aa72-3288-c1a9-d6f1-3998c15d630e@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,


On 5/19/2021 12:18 PM, Li Wang wrote:
>
> I'm wondering if this is zsh feature or a bug on a specific version?
> if the latter, we probably have no need to fix it in LTP.
> Btw, which zsh version do you use?
>
> Odd, I tried on my laptop(Fedora34) with zsh-5.5.1-6.el8_1.2.x86_64,
> but could NOT reproduce it.
>
> my reproducer:
> -----------------
>
> # cat test.sh
>
> echo "pid is $$" # send TERM to pid in another terminal
>
> sleep 100 &
> sleep_pid=$!
>
> trap "kill $sleep_pid; exit;" TERM
>
> wait $sleep_pid
> [ $? -eq 143 ] && echo "FAIL"
>

I may have something to do with subshells again...
I just tweaked your reproducer, to be a bit more like our "real 
scenario" and can reproduce it:

timeout()
{
 ??? sleep 100 &
 ??? sleep_pid=$!
 ??? trap "echo Received TERM; kill $sleep_pid; exit;" TERM
 ??? wait $sleep_pid
 ??? [ $? -eq 143 ] && echo "FAIL"
}

timeout &
pid=$!
sleep 1
kill $pid


$ bash test.sh
Received TERM

$ zsh test.sh
Received TERM
FAIL

J?rg


