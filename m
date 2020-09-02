From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 Sep 2020 19:17:17 +0200
Subject: [LTP] [PATCH v2 4/4] ioctl_sg01: Loop data leak check 100 times
In-Reply-To: <20200825160735.24602-5-mdoucha@suse.cz>
References: <20200825160735.24602-1-mdoucha@suse.cz>
 <20200825160735.24602-5-mdoucha@suse.cz>
Message-ID: <20200902171717.GC26811@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Even with pre-polluted memory, running the test just once might result in
> a false negative. Loop it a few times to increase reliability.

Obviously ok.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW do I understand the test correctly: we expect ioctl() return -1 because we
use uninitialized command[CMD_SIZE] in query.cmdp (as the requirement for empty
command in kernel commit message)?

Kind regards,
Petr
