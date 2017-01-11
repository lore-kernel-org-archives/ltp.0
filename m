From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Jan 2017 13:58:57 +0100
Subject: [LTP] [PATCH 1/1] travis: initial configuration
In-Reply-To: <20170111124229.18935-1-petr.vorel@gmail.com>
References: <20170111124229.18935-1-petr.vorel@gmail.com>
Message-ID: <20170111125857.GB8806@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Configuration: build with gcc only, install, email to mailing list in
> case of error or change (previously broken build was just fixed).

I guess that this can go in immediately since there is no chance that
this will break anything.

FYI for everyone, I've just added a ltp-travis account to LTP GitHub
project (giving travis access to my account or any personal account
seemed too scary to me, especially since there does not seem to be any
access controll available).

-- 
Cyril Hrubis
chrubis@suse.cz
