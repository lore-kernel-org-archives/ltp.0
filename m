From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Feb 2016 16:44:37 +0100
Subject: [LTP] [PATCH v2] syscalls/renameat202: improve
	renameat2_verify()
In-Reply-To: <1455804735-20998-1-git-send-email-eguan@redhat.com>
References: <1455713810-21842-1-git-send-email-eguan@redhat.com>
 <1455804735-20998-1-git-send-email-eguan@redhat.com>
Message-ID: <20160218154437.GA21675@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two minor changes:

* used sizeof(content) - 1 instead of strlen()

* used ' to quote string in restult instead of \"

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
