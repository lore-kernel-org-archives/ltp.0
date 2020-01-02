From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 2 Jan 2020 05:01:26 -0500 (EST)
Subject: [LTP] [PATCH v3] Use real FS block size in fallocate05
In-Reply-To: <20191218131533.15323-1-mdoucha@suse.cz>
References: <461386048.17251961.1576663655809.JavaMail.zimbra@redhat.com>
 <20191218131533.15323-1-mdoucha@suse.cz>
Message-ID: <1771713636.197122.1577959286001.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> fallocate() behavior depends on whether the file range is aligned to full
> blocks. Make sure that the test always uses aligned file range so that
> the test is consistent across platforms.
> 
> Also use the TEST() macro to prevent errno pollution and increase test device
> size to avoid weird edge cases that don't happen in the real world.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

Acked-by: Jan Stancek <jstancek@redhat.com>

