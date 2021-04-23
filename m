From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 23 Apr 2021 17:28:48 +0200
Subject: [LTP] [PATCH] mkfs: relax size check
In-Reply-To: <YILiiDe5gv4d2Gg5@pevik>
References: <f224defc029816a74c518c54af2fbf2b90a90da6.1619176445.git.jstancek@redhat.com>
 <YILiiDe5gv4d2Gg5@pevik>
Message-ID: <YILnsJsRiHorSBVc@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> Yes, I also noticed mkfs01_ext3_sh and mkfs01_ext4_sh on mainline, this could
> help. Thanks!
Yes, it fixes the problem otherwise reproducible on openSUSE, which uses
e2fsprogs 1.46.2 with commit 59037c53.

Kind regards,
Petr
