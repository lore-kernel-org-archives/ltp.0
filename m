From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Nov 2018 18:46:17 +0100
Subject: [LTP] [PATCH v4] Testing statx syscall Timestamp fields
In-Reply-To: <20181109113014.6756-1-subash@zilogic.com>
References: <20181109113014.6756-1-subash@zilogic.com>
Message-ID: <20181119174617.GD28106@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* Changed the tst_test structure to pass -I 256 instead of specifying
  minimal size for the image

* Removed additional \n from the TPASS message

-- 
Cyril Hrubis
chrubis@suse.cz
