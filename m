From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 10 Mar 2021 07:55:19 -0500 (EST)
Subject: [LTP] [PATCH 0/3] Add proper filesystem skiplist
In-Reply-To: <20210310122625.25425-1-chrubis@suse.cz>
References: <20210310122625.25425-1-chrubis@suse.cz>
Message-ID: <1320332024.40018791.1615380919351.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This adds a proper .skip_filesystems array to the tst_test structure and
> implements support for both test with .all_filesystems enabled and
> disabled.
> 
> As a bonus point we get the list of filesystems that the test does not
> support exported to the metadata as well.

Ack. Can you please also add something to docs?

