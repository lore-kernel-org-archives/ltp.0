From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Apr 2021 10:51:45 +0200
Subject: [LTP] [PATCH] lapi/syscalls: Correct syscall numbers for all
 MIPS arches
In-Reply-To: <20210402045331.18686-1-zhe.he@windriver.com>
References: <20210402045331.18686-1-zhe.he@windriver.com>
Message-ID: <YGwhIRy5xQYYYFxG@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhe,

> Add the offsets to syscall numbers for o32 n32 and n64.

Thanks, merged.
I re-added underscored definitions: _llseek, _newselect, _sysctl.
_llseek has not been used in LTP, but __NR__sysctl and __NR__newselect are.

Kind regards,
Petr
