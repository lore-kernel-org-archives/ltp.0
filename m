From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Dec 2020 16:37:51 +0100
Subject: [LTP] [PATCH 1/3] syscalls/ipc: shmctl04: Test SHM_STAT_ANY
 with nobody user
In-Reply-To: <1607422067-15500-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1607422067-15500-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <X8+dz1KYgnvaOghB@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

> +static struct passwd *ltpuser;

I've moved this structure to the test setup() since there is no point in
having otherwise unused global variable.

-- 
Cyril Hrubis
chrubis@suse.cz
