From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 14 Aug 2020 17:42:12 +0200
Subject: [LTP] [PATCH 2/4] Update tests to new taint check API
In-Reply-To: <20200814153803.GB30390@dell5510>
References: <20200811130502.12010-1-mdoucha@suse.cz>
 <20200811130502.12010-2-mdoucha@suse.cz> <20200814153803.GB30390@dell5510>
Message-ID: <2b34ef8e-2697-7692-8c96-9e1fa25140a1@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14. 08. 20 17:38, Petr Vorel wrote:
> Have you tried to use .taint_check also for testcases/kernel/crypto/af_alg07.c
> and testcases/kernel/syscalls/bpf/bpf_prog04.c?

I'm planning to update those on Monday after I submit the CVE test I'm
working on right now. But feel free to update them when you merge this
patchset.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
