From: Sandeep Patil <sspatil@android.com>
Date: Tue, 26 Mar 2019 21:48:56 +0900
Subject: [LTP] [PATCH 0/4] Convert tests to use new library
In-Reply-To: <20190326094228.GC17897@rei.lan>
References: <20190325232012.67123-1-sspatil@android.com>
 <20190326094228.GC17897@rei.lan>
Message-ID: <20190326124856.GD5826@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 26, 2019 at 10:42:28AM +0100, Cyril Hrubis wrote:
> Hi!
> > I've only tested these with glibc + x86 vm. I removed some of the
> > UCLINUX specific ifdefs in the process that I am not so sure about.
> > Is there a way for me to test these on other systems?
> 
> The uClinux support has been deprecated and we are slowly removing the
> support. The uClinux project itself seems to be dead so it does not make
> sense to keep supporting it.

Great, good to know. I am literally going through tests in alphabetical
orders and convert as many as I can in this sprint. This information helps to
clean things up in the process too ..

- ssp

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
