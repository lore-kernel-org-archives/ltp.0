From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 24 Jun 2021 16:13:54 +0200
Subject: [LTP] [PATCH] lib: memutils: don't pollute entire system memory
 to avoid OoM
In-Reply-To: <CAEemH2eSNnhwnOOOMoUf5Xv0uup_ZTJMDncLsgkChcULY37RfQ@mail.gmail.com>
References: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
 <018a369f-473b-524d-f81b-eb8be4df49bb@suse.cz>
 <CAEemH2eSNnhwnOOOMoUf5Xv0uup_ZTJMDncLsgkChcULY37RfQ@mail.gmail.com>
Message-ID: <2cd76a1c-d944-d19b-ce21-1696602573c4@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24. 06. 21 16:00, Li Wang wrote:
> FYI, Another related analysis:
> https://lists.linux.it/pipermail/ltp/2021-April/021903.html
> <https://lists.linux.it/pipermail/ltp/2021-April/021903.html>
> 
> The mmap() behavior changed in GUESS mode from commit 8c7829b04c523cd,
> we can NOT receive MAP_FAILED on ENOMEM in userspace anymore,unless?
> the process one-time allocating memory larger than "total_ram+
> total_swap" explicitly.
> 
> Which also means the MAP_FAILED check lose effect?permanently in line#51:
> https://github.com/linux-test-project/ltp/blob/master/lib/tst_memutils.c#L51
> <https://github.com/linux-test-project/ltp/blob/master/lib/tst_memutils.c#L51>

I'm pretty sure that 32bit x86 kernel with PAE and more than 3GB of RAM
will give you MAP_FAILED because you'll run out of available address
space before you run out of physical memory.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
