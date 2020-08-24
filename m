From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 24 Aug 2020 19:19:43 +0200
Subject: [LTP] [LTP v4 1/5] IMA/ima_keys.sh: Fix policy content check
 usage
In-Reply-To: <20200820090824.3033-2-pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-2-pvorel@suse.cz>
Message-ID: <20200824171943.GA15693@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> require_ima_policy_content cannot be used in subshell $() evaluation,
> because tst_brk does not quit the test. It calls cleanup for the
> subshell process and main process then continue:
...

Merged this one to at least fix ima_keys.sh test.
I'll wait little longer before merging the rest of v4 patchset
https://patchwork.ozlabs.org/project/ltp/list/?series=196621

Kind regards,
Petr
