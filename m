From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 3 Mar 2020 12:34:18 +0100
Subject: [LTP] [PATCH v2] Add test for CVE 2017-10661
In-Reply-To: <20200303112725.GA24389@rei.lan>
References: <20200221120850.15874-1-mdoucha@suse.cz>
 <20200303104737.GA42129@gacrux.arch.suse.de>
 <20200303110249.GB42129@gacrux.arch.suse.de> <20200303112725.GA24389@rei.lan>
Message-ID: <74b99e9f-12a3-6d5b-2d14-16fd3cbd4c71@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 3/3/20 12:27 PM, Cyril Hrubis wrote:
>> OK: it can be just this:
>> timerfd_settime02:	CFLAGS	+= -pthread
>> timerfd_settime02:	LDLIBS	+= -lrt
>>
>> because failure in CentOS 6 is different:
>> timerfd01.c:36: undefined reference to `clock_gettime'
>> https://api.travis-ci.org/v3/job/657694167/log.txt
>>
>> Obviously we need autotools check for it (trivial, I can do it before merge).
> 
> -lrt is required in LDLIBS for older libc that had all the posix
> realtime outside of the glibc.so, and it's harmless on newer glibc so
> for the time being we just need -lrt in LDLIBS for quite a lot of
> testcases...
> 

Ah, right. I broke the Makefile when I deleted the unconditional LDLIBS
line... The -lpthread was useless but I didn't realize the -lrt was needed.

I'll resubmit with all fixes mentioned so far then.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
