From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 26 Jul 2019 11:43:38 +0200
Subject: [LTP] [PATCH] *.sh: convert hardcoded python2 to python3
In-Reply-To: <1563785844-28983-1-git-send-email-yi.zhao@windriver.com>
References: <1563785844-28983-1-git-send-email-yi.zhao@windriver.com>
Message-ID: <20190726094338.GA16006@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yi,

> We had converted python2 to python3 for all *.py in commit
> 5a8408bc32f0eada5cbf65ac63d5cd2410f95249. But there are still hardcoded
> python2 in some scripts. Convert these python2 to python3.


> -python create_users.py -u 50 -g 50
> +python3 create_users.py -u 50 -g 50
BTW at least some of them could be run directly, i.e.
./create_users.py -u 50 -g 50

BTW do you run this test? As it's not installed (must be run from source tree).

Kind regards,
Petr
