From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 3 Sep 2020 17:50:30 +0200
Subject: [LTP] [PATCH] Add test for send(MSG_MORE)
In-Reply-To: <20200828151747.21445-1-mdoucha@suse.cz>
References: <20200828151747.21445-1-mdoucha@suse.cz>
Message-ID: <20200903155030.GA23664@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> The setsockopt05 test will not work properly if kernel handles the MSG_MORE
> flag incorrectly. Add a new test to detect broken test environment.

Thanks for your patch, merged.

Kind regards,
Petr
