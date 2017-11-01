From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Nov 2017 15:12:05 +0100
Subject: [LTP] [PATCH] Add test for cve-2016-9604 on
 keyctl_join_session_keyring(".name")
In-Reply-To: <20171002141937.17321-1-rpalethorpe@suse.com>
References: <20171002141937.17321-1-rpalethorpe@suse.com>
Message-ID: <20171101141205.GA11108@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I wonder if we should rather put the test under keyctl08.c, otherwise
it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
