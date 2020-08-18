From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Aug 2020 10:16:32 +0200
Subject: [LTP] [PATCH 2/4] Update tests to new taint check API
In-Reply-To: <2b34ef8e-2697-7692-8c96-9e1fa25140a1@suse.cz>
References: <20200811130502.12010-1-mdoucha@suse.cz>
 <20200811130502.12010-2-mdoucha@suse.cz>
 <20200814153803.GB30390@dell5510>
 <2b34ef8e-2697-7692-8c96-9e1fa25140a1@suse.cz>
Message-ID: <20200818081632.GA21491@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> On 14. 08. 20 17:38, Petr Vorel wrote:
> > Have you tried to use .taint_check also for testcases/kernel/crypto/af_alg07.c
> > and testcases/kernel/syscalls/bpf/bpf_prog04.c?

> I'm planning to update those on Monday after I submit the CVE test I'm
> working on right now. But feel free to update them when you merge this
> patchset.
I changed also these 2 tests and merged whole patch.
Thanks!

Kind regards,
Petr
