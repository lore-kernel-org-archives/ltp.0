From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 7 Jun 2017 06:50:48 -0400 (EDT)
Subject: [LTP] [PATCH 1/1] do not test undefined behavior
In-Reply-To: <1496682046-19155-1-git-send-email-martin.karac@oracle.com>
References: <1496682046-19155-1-git-send-email-martin.karac@oracle.com>
Message-ID: <1547767732.30867058.1496832648073.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Flag files are an interface which is known to expect numeric values.
> We already have a test in test_flags() which covers invalid input.
> We should not attempt to write a space into a flag file because
> the resulting behavior is not strictly defined anywhere.
> Therefore, it would be best to drop the first test.

Pushed.

Thanks,
Jan
