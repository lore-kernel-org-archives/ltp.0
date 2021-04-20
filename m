From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Apr 2021 16:01:18 +0800
Subject: [LTP] [PATCH 1/1] zram01.sh: Skip tmpfs
In-Reply-To: <20210420061759.22457-1-pvorel@suse.cz>
References: <20210420061759.22457-1-pvorel@suse.cz>
Message-ID: <CAEemH2fD45RCJwKYtrTj7H3vZaBHU=Y2e2zu8V1YepnOKOSC1A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

This patch looks good.

Reviewed-by: Li Wang <liwang@redhat.com>

I am now thinking, does that make sense to add FS skiplist to
tst_test.sh just like we have done for C lib?

-- 
Regards,
Li Wang

