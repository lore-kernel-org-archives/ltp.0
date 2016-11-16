From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 16 Nov 2016 12:34:36 +0800
Subject: [LTP] [PATCH v3] syscalls/recvmsg03.c: add new testcase
In-Reply-To: <20161115140446.GD13947@rei.lan>
References: <20161102130647.GB22840@rei.lan>
 <1478159398-10268-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <58251F30.4060502@cn.fujitsu.com> <20161115140446.GD13947@rei.lan>
Message-ID: <582BE1DC.5050304@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2016/11/15 22:04, Cyril Hrubis wrote:
> Hi!
>> Hi Cyril!
>>
>> Ping :-)
> Any hints on what distribution is this bug reproducible? I've looked
> around my collection of virtual machines and everything is either too
> old or too new.
>
Hi cyril

When I built kernel with CONFIG_RDS enabled,  I have tested it and 
reproduced this bug on
v3.5 kernel without the fix patch.

I will resend the v3 patch because we need to make sure that recvmsg() 
can succeed to get data.

Thanks,
Xiao Yang


