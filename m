From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 11 Jun 2020 07:33:56 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/fork14: Fix Buffer overflow
In-Reply-To: <20200609071611.9467-1-vikas.kumar2@arm.com>
References: <20200609071611.9467-1-vikas.kumar2@arm.com>
Message-ID: <1118360748.15618585.1591875236530.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This change basically avoids the buffer overflow by keeping the check count
> to allocation limit
> The problem occurs when there is no failure and i == EXTENT, so
> pointer_vec[EXTENT] goes beyond the allocated buffer.

I changed the patch to use a new variable, that reflects number of used
fields, and pushed.

Thanks,
Jan

