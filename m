From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Mar 2019 17:37:55 +0100
Subject: [LTP] [RFC PATCH 1/1] shell: Remove tst_su
In-Reply-To: <20190327163120.11358-1-pvorel@suse.cz>
References: <20190327163120.11358-1-pvorel@suse.cz>
Message-ID: <20190327163755.GB10106@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks like we removed last user of that API in:

commit 0fc9b8624bea8acfdb408bf5ff4916b1453e3daa
Author: Petr Vorel <pvorel@suse.cz>
Date:   Thu Sep 27 16:57:20 2018 +0200

    Remove admin_tools test


Hence acked.

-- 
Cyril Hrubis
chrubis@suse.cz
