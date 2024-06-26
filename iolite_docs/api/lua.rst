.. _api_lua:

Lua API
=======

This section is a reference guide for the Lua scripting interface in IOLITE.

.. note:: The Lua API in IOLITE is provided via a `native C++ plugin <https://github.com/MissingDeadlines/iolite/tree/main/iolite_plugins/lua_plugin>`_ and is freely available in our GitHub repository. Have a look at the plugin to inspect the underlying implementation of the exposed functions or to customize/extend the implementation.

IOLITE Lua API header file
--------------------------

The IOLITE Lua API header file can be used to add auto-completion to the code editor of your choice. This has been tested in `Visual Studio Code <https://code.visualstudio.com/>`_ using the latest version of the `Lua extension <https://marketplace.visualstudio.com/items?itemName=sumneko.lua>`_.

Click the following link to download the latest version of the header file and drop it somewhere close to your scripts:

* :download:`iolite_api.lua </_static/iolite_api.lua>`
   
.. include:: lua_generated.rst