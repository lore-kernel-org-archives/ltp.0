From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 May 2019 13:51:49 +0200
Subject: [LTP] [PATCH 5/5] syscalls/bind01: convert to new library.
In-Reply-To: <20190519003808.47425-6-sspatil@android.com>
References: <20190519003808.47425-1-sspatil@android.com>
 <20190519003808.47425-6-sspatil@android.com>
Message-ID: <20190529115149.GA569@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Unfortunatelly this does not apply cleanly after:

commit fa6a4e708495d9177eca395717ebab4ee9afd8d6
Author: Petr Vorel <pvorel@suse.cz>
Date:   Tue Apr 23 21:38:23 2019 +0200

    net: Introduce TST_GET_UNUSED_PORT() macro into C API


Can you please rebase your commit?

-- 
Cyril Hrubis
chrubis@suse.cz
