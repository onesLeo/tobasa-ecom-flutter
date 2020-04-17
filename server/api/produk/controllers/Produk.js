'use strict';

/**
 * Produk.js controller
 *
 * @description: A set of functions called "actions" for managing `Produk`.
 */

module.exports = {

  /**
   * Retrieve produk records.
   *
   * @return {Object|Array}
   */

  find: async (ctx, next, { populate } = {}) => {
    if (ctx.query._q) {
      return strapi.services.produk.search(ctx.query);
    } else {
      return strapi.services.produk.fetchAll(ctx.query, populate);
    }
  },

  /**
   * Retrieve a produk record.
   *
   * @return {Object}
   */

  findOne: async (ctx) => {
    if (!ctx.params._id.match(/^[0-9a-fA-F]{24}$/)) {
      return ctx.notFound();
    }

    return strapi.services.produk.fetch(ctx.params);
  },

  /**
   * Count produk records.
   *
   * @return {Number}
   */

  count: async (ctx) => {
    return strapi.services.produk.count(ctx.query);
  },

  /**
   * Create a/an produk record.
   *
   * @return {Object}
   */

  create: async (ctx) => {
    return strapi.services.produk.add(ctx.request.body);
  },

  /**
   * Update a/an produk record.
   *
   * @return {Object}
   */

  update: async (ctx, next) => {
    return strapi.services.produk.edit(ctx.params, ctx.request.body) ;
  },

  /**
   * Destroy a/an produk record.
   *
   * @return {Object}
   */

  destroy: async (ctx, next) => {
    return strapi.services.produk.remove(ctx.params);
  }
};
