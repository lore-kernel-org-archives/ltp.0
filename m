From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Mar 2017 15:13:35 +0100
Subject: [LTP] [PATCH] syscalls/keyctl02: Add new regression test
In-Reply-To: <1487644775-12365-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1487644775-12365-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170302141335.GB27525@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Fixed by:
> commit b4a1b4f5047e4f54e194681125c74c0aa64d637d
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Dec 18 01:34:26 2015 +0000
> 
>     KEYS: Fix race between read and revoke

Looks good, the original reproducer uses four threads instead of two
though. Are two enough to crash the buggy kernel with 100% probability?

-- 
Cyril Hrubis
chrubis@suse.cz
