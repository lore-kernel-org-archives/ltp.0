From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jun 2018 15:49:31 +0200
Subject: [LTP] [PATCH v2] open08: rewrite to newlib
In-Reply-To: <CAEemH2fi7AieoSP7kAusuTjR81kab1CFgfiGerVwZyngNDPYLA@mail.gmail.com>
References: <787996724f38cfa88d0a8c9a0a713d056ba01307.1528980323.git.jstancek@redhat.com>
 <CAEemH2dFRruWBBU+p5qU5vtGxc-ibjbFpW5TjNd=P0G=7TALfA@mail.gmail.com>
 <CAEemH2eLzFsjx=3yhP-qN6=P=3DwJ9txR_0TfE2iYUhB7qiXoQ@mail.gmail.com>
 <334996146.26786343.1529043115414.JavaMail.zimbra@redhat.com>
 <CAEemH2fi7AieoSP7kAusuTjR81kab1CFgfiGerVwZyngNDPYLA@mail.gmail.com>
Message-ID: <20180626134929.GA14777@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > But we could set it to some special value (NULL) and check all cases against that.
> > If it's NULL, then make a bad_addr.
> 
> Agreed.

Either we do that or make the addr pointer to a pointer in the test
structure and make it to point to a global variable initialized in the
test setup as we do in some tests as well.

-- 
Cyril Hrubis
chrubis@suse.cz
