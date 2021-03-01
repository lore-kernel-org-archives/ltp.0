From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Mar 2021 15:57:16 +0100
Subject: [LTP] [PATCH v2 4/6] zram: Move test specific functions out of
 zram_lib.sh
In-Reply-To: <20210129194144.31299-5-pvorel@suse.cz>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-5-pvorel@suse.cz>
Message-ID: <YD0AzHnQHCtt7BRp@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This is okay, but we should keep the zram_compress_alg() in the lib if
we are going to have the test step in both tests.

-- 
Cyril Hrubis
chrubis@suse.cz
