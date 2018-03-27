From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Mar 2018 15:40:56 +0200
Subject: [LTP] [PATCH ltp] tools/apicmds/.gitignore: add tst_flush
In-Reply-To: <20180327132224.15897-1-yixin.zhang@intel.com>
References: <20180327132224.15897-1-yixin.zhang@intel.com>
Message-ID: <20180327134056.GA31563@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Actually the tst_flush has been removed in:

commit eb50f0a9e0c26f3cab8472f47a2ea8171ce5ee52
Author: Michael Moese <mmoese@suse.de>
Date:   Fri Mar 9 15:16:07 2018 +0100

    remove old tst_flush()

So the right solution is to remove it from the Makefile. I will commit
that, thanks for the report.

-- 
Cyril Hrubis
chrubis@suse.cz
