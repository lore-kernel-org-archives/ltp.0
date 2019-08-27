From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Aug 2019 11:58:58 +0200
Subject: [LTP] [PATCH v2] syscalls/statx04: use stx_attributes_mask
 before test
In-Reply-To: <20190827092520.GA28859@dell5510>
References: <20190802115046.GB27727@rei>
 <1566282838-2980-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190827092520.GA28859@dell5510>
Message-ID: <20190827095858.GB28859@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

also Cyril noted on Github issue #557 [1]:
"However I'm not sure that we should do this since kernel devs declared this to be bug after all."

So maybe we should wait before applying it.

@Cyril: can you please post link to discussion in LKML?

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/557#issuecomment-522593891
