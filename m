From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 3 Mar 2020 12:26:48 +0100
Subject: [LTP] [PATCH v2] Add test for CVE 2017-10661
In-Reply-To: <20200303110249.GB42129@gacrux.arch.suse.de>
References: <20200221120850.15874-1-mdoucha@suse.cz>
 <20200303104737.GA42129@gacrux.arch.suse.de>
 <20200303110249.GB42129@gacrux.arch.suse.de>
Message-ID: <f3da1aa4-f91b-91e2-2e16-b2836355bf89@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 3/3/20 12:02 PM, Petr Vorel wrote:
> because failure in CentOS 6 is different:
> timerfd01.c:36: undefined reference to `clock_gettime'
> https://api.travis-ci.org/v3/job/657694167/log.txt
> 
> Obviously we need autotools check for it (trivial, I can do it before merge).

Note that this is a compile error in completely different test program.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
