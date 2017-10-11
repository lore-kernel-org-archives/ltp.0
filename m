From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 11 Oct 2017 03:45:59 -0400 (EDT)
Subject: [LTP] [PATCH 4/6] lib: extend PATH as part of test setup
In-Reply-To: <20171010151852.GA12028@rei>
References: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
 <fe40d9a0263afff913c646a6bc1fad88e0ce9747.1507647255.git.jstancek@redhat.com>
 <20171010151852.GA12028@rei>
Message-ID: <1402903291.28351700.1507707959540.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> I do not like the strcat() function much, I would have probably handled
> these with asprintf();
> 
> 	if (old_path)
> 		SAFE_ASPRINTF(&new_path, "%s::%s", old_path, start_dir);
> 	else
> 		SAFE_ASPRINTF(&new_path, "::%s", start_dir);

This makes it simpler, I've modified it to use SAFE_ASPRINTF.

> 
> 
> The rest of the patchset looks good.

I pushed all with your ACK.

> 
> BTW, we should also drop the note about setting $PATH from the
> documentation once this is merged.

Or tweak it to say, it's no longer necessary for newlib tests.

Regards,
Jan
