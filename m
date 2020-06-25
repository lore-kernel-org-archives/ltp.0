From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Jun 2020 14:34:56 +0200
Subject: [LTP] [PATCH 1/2] tst_test: Add support for device discovery
In-Reply-To: <a1189d10-1539-2486-3d78-ede985d0f79e@ti.com>
References: <20200623112827.10744-1-chrubis@suse.cz>
 <20200623112827.10744-2-chrubis@suse.cz>
 <a1189d10-1539-2486-3d78-ede985d0f79e@ti.com>
Message-ID: <20200625123456.GE23637@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I think we a need:
> 
> 1) A common way to define Hardware capabilities, i.e. UART_RX and 
> UART_TX in your example.
> 
> I suspect for device-driver tests, ltp would be called by a test 
> automation framework. It should be the test automation framework 
> responsibility to setup the equipment per the HW capabilities requested 
> by the test.
>
> So from ltp point of view, the only requirement is to advertise the 
> required capabilities. Of course, this implies a common understanding of 
> the capabilities' tags.

I do agree here, but this will not work until we have the metadata
export in place. Once we have the infrastructure to generate the
description of the tests the test automation will simply load the JSON
file and then run tests and reconfigure the hardware between loops as
needed.

But that would mean that we will not have an upstream solution until we
get rid of ltp-pan and runtest files. This is fine with me as I actually
want to get the metadata generator in LTP tree soon enough.

> 2) A way to set platform-specific values when required. Ideally the test 
> logic can figure out the values to use dynamically but for some test 
> cases, it is required to statically defined them based on the platform 
> the test is running on.
> 
> In ltp-ddt we added this functionality as platform overrides 
> http://arago-project.org/git/projects/?p=test-automation/ltp-ddt.git;a=blob;f=README-DDT;h=78b79cd3ca0f66a6ef30b5dc05737188c146a9ca;hb=HEAD#l46, 
> borrowing an idea from OE/Yocto world. I think a different approach 
> where these info is maintained in a separate file with an API that it is 
> called by the test case logic would work. However, I think that this 
> information is not lab-specific but board-specific and it should be part 
> of ltp.

I'm not convinced that this belongs to LTP git but we can setup a shared
git repo for platform descriptions if things go well.

-- 
Cyril Hrubis
chrubis@suse.cz
