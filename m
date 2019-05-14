From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 May 2019 14:12:13 +0200
Subject: [LTP] [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
In-Reply-To: <20190405165225.27216-1-pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
Message-ID: <20190514121213.GA28655@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi, Ignaz,

Mimi, could you please have a second look on this [4] patchset? We've had a
discussion about second patch [5], I can drop it if you don't like it, but
that's not a main concern about this test. More important is whether the
testcase looks valid for you. It's about overlayfs broken in IMA+EVM,
which is currently broken on mainline.
There is different reproducer (C code) for a slightly different scenario,
but I'm not going to port it before this got merged.

Ignaz, could you please test this patchset? Could you, please, share your setup?
ima_policy=appraise_tcb kernel parameter and loading IMA and EVM keys over
dracut-ima scripts? (IMA appraisal and EVM using digital signatures? I guess
using hashes for IMA appraisal would work as well).

Kind regards,
Petr

> this is a second version of patch demonstrating a bug on overlayfs when
> combining IMA with EVM. There is ongoing work made by Ignaz Forster and
> Fabian Vogt [1] [2], IMA only behavior was already fixed [3].

> Main patch is the last one (previous are just a cleanup and not changed).

> [1] https://www.spinics.net/lists/linux-integrity/msg05926.html
> [2] https://www.spinics.net/lists/linux-integrity/msg03593.html
> [3] https://patchwork.kernel.org/patch/10776231/

[4] https://patchwork.ozlabs.org/project/ltp/list/?series=101213&state=*
[5] https://patchwork.ozlabs.org/patch/1078553/
