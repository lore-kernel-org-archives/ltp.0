From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Mar 2021 20:08:01 +0200
Subject: [LTP] [PATCH 2/2] pec: Fix multiple event test
In-Reply-To: <20210315092844.991073-2-lkml@jv-coder.de>
References: <20210315092844.991073-1-lkml@jv-coder.de>
 <20210315092844.991073-2-lkml@jv-coder.de>
Message-ID: <YGIXgYVBSs5V3Stk@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

Test is defined as #!/bin/bash which is not acceptable [1], I'm going to change
it as #!/bin/sh. Also note a need to check with checkbashism.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#132-shell-coding-style
