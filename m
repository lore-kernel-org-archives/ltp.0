From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 21 Apr 2020 16:27:24 +0800
Subject: [LTP] [PATCH v3 1/3] syscalls/pipe2_01: convert into new API
In-Reply-To: <CAEemH2dfPZs_DQxm33hsaYTXcsxddA0TTTMcbCuZgjekvCCGPA@mail.gmail.com>
References: <1586927503-10827-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2dfPZs_DQxm33hsaYTXcsxddA0TTTMcbCuZgjekvCCGPA@mail.gmail.com>
Message-ID: <0dcbceee-2f6f-86a5-9fce-765677bdbb2d@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li

>     -}
>     +static struct tcase {
>     +? ? ? ?int flags;
>     +? ? ? ?int check_cmd;
> 
> 
> The 'check_cmd' sounds strange here since we don't do any check for the 
> cmd, can we use 'cmd' directly?
Yes.
> 
>     +? ? ? ?int check_read_side;
> 
> 
> A pipe has a read-end and a write-end. So I prefer to call this 
> 'check_read_end', do you agree?
Agree. man-pages also said "the read/write end of the pipe". Thanks for 
pointing out this.
> 
>     +? ? ? ?char *message;
>     +} tcases[] = {


