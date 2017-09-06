From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Sep 2017 15:21:31 +0200
Subject: [LTP] [RFC PATCH 6/6] android: cve/stack_clash: Fix warning
In-Reply-To: <20170902005926.15923-7-petr.vorel@gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
 <20170902005926.15923-7-petr.vorel@gmail.com>
Message-ID: <20170906132131.GH24177@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> format '%lx' expects argument of type 'long unsigned int', but argument 8 has type 'ssize_t'

ssize_t should be printed by %zi these days

-- 
Cyril Hrubis
chrubis@suse.cz
