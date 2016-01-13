From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Jan 2016 21:42:40 +0100
Subject: [LTP] [PATCH] controllers/cgroup_fj: remove broken testcase
In-Reply-To: <1451040253-2430-1-git-send-email-cedric@hnyda.net>
References: <1451040253-2430-1-git-send-email-cedric@hnyda.net>
Message-ID: <20160113204240.GB29398@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed albeit with a different commit description. There actually is
backward compatible layer in kernel that provides the interface without
the prefix when you pass the mount option. But given that we cannot
mount cgroups on newer systems and the test fails there and that the
single testcase overcomplicates the test structure its better if we get
rid of it.

-- 
Cyril Hrubis
chrubis@suse.cz
