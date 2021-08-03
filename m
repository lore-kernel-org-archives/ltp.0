From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 3 Aug 2021 13:34:11 +0200
Subject: [LTP] [PATCH v7 2/7] test/test_zero_hugepage.sh: Skip test on
 read-only file system
In-Reply-To: <YQkLmb3pUPY8cKP8@yuki>
References: <20210802173536.19525-1-pvorel@suse.cz>
 <20210802173536.19525-3-pvorel@suse.cz> <YQkLmb3pUPY8cKP8@yuki>
Message-ID: <YQkps5nZ8gHJSaUQ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> I wonder if we should rather check if proc is mounted readonly
> explicitly since this may hide all kinds of errors.
Sure, makes sense, I'll adapt it in v8. It's just not a fun to write tests which
you cannot debug on VM, but just pushing to git :(.

Kind regards,
Petr
