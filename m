From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jun 2018 11:38:50 +0200
Subject: [LTP] [PATCH] cve/meltdown: read *saved_command_line
In-Reply-To: <761d2d176c0765f3913e140191ceaf83aa745424.1529495077.git.jstancek@redhat.com>
References: <761d2d176c0765f3913e140191ceaf83aa745424.1529495077.git.jstancek@redhat.com>
Message-ID: <20180626093850.GE24288@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looking at kernel git the saved_command_line is allocated dynamically
since 2.6.21 which I guess is old enough but we may as well mention this
in the commit message:

commit 30d7e0d466b3ac0b5ef77e4062bf9385f0d72270
Author: Alon Bar-Lev <alon.barlev@gmail.com>
Date:   Mon Feb 12 00:53:52 2007 -0800

    [PATCH] Dynamic kernel command-line: common


Other than that it looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
