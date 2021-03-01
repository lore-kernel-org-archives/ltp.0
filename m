From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Mar 2021 16:06:33 +0100
Subject: [LTP] [RFC PATCH v2 5/6] tst_test.sh: Run _tst_setup_timer
 after $TST_SETUP
In-Reply-To: <20210129194144.31299-6-pvorel@suse.cz>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-6-pvorel@suse.cz>
Message-ID: <YD0C+dEY5v7RHfZQ@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
We do have a function to set the timeout in the C library
(tst_set_timeout), maybe we should just add one to the shell just to
match the API.

-- 
Cyril Hrubis
chrubis@suse.cz
