From: Li Wang <liwang@redhat.com>
Date: Mon, 8 Mar 2021 17:04:51 +0800
Subject: [LTP] [RFC PATCH v2 3/7] Add new CGroups Core and Item APIs
In-Reply-To: <20210302152510.15116-4-rpalethorpe@suse.com>
References: <20210302152510.15116-1-rpalethorpe@suse.com>
 <20210302152510.15116-4-rpalethorpe@suse.com>
Message-ID: <CAEemH2fO7Bon38PX5Moq4YxWyXRN67yMX9b6HUyp7Wj4_vT=Jw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

Thanks for your refactor, this is much better than what I have written
before:).

But I have to say this version is complicated since there are many
interlaced structures defined, especially for the cgroup-item part.
And my concern is that it might unfriendly to maintainers and users.

Anyway, I still need time to understand the whole part and will
try to reduce something to make it more simplified if I can.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210308/eb9155fd/attachment.htm>
